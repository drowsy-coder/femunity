import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:femunity/core/faliures.dart';
import 'package:femunity/core/providers/firebase_providers.dart';
import 'package:femunity/core/providers/storage_repository_provider.dart';
import 'package:femunity/core/utils.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/communities/repository/community_repository.dart';
import 'package:femunity/features/communities/screens/create_community_sc.dart';
import 'package:femunity/models/community_model.dart';
import 'package:femunity/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return communityController.getUserCommunities();
});

final getCommunityPostsProvider = StreamProvider.family((ref, String name) {
  return ref.read(communityControllerProvider.notifier).getCommunityPosts(name);
});

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return CommunityController(
      communityRepository: communityRepository,
      ref: ref,
      storageRepository: storageRepository);
});

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityByName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;
  CommunityController({
    required CommunityRepository communityRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _communityRepository = communityRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';

    if (name.contains(' ')) {
      showSnackBar(context, 'Community name cannot contain a space!');

      state = false;
      return;
    }

    Community community = Community(
      id: name,
      name: name,
      banner: Constants.bannerDefault,
      avatar: Constants.avatarDefault,
      members: [uid],
      mods: [uid],
    );
    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold(
      (l) => showSnackBar(context, 'Community created successfully'),
      (r) => Routemaster.of(context).pop(),
    );
  }

  void joinCommunity(Community community, BuildContext context) async {
    final user = _ref.read(userProvider)!;

    Either<Failure, void> res;

    if (community.members.contains(user.uid)) {
      res = await _communityRepository.leaveCommunity(community.name, user.uid);
    } else {
      res = await _communityRepository.joinCommunity(community.name, user.uid);
    }
    res.fold((l) => showSnackBar(context, l.message), (r) {
      if (community.members.contains(user.uid)) {
        showSnackBar(context, 'You are no longer a part of ${community.name}!');
      } else {
        showSnackBar(context, 'You are now a part of ${community.name}!');
      }
    });
  }

  Stream<List<Community>> getUserCommunities() {
    final uid = _ref.read(userProvider)!.uid;
    return _communityRepository.getUserCommunities(uid);
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

  void editCommunity({
    required File? profileFile,
    required File? bannerFile,
    required BuildContext context,
    required Community community,
  }) async {
    state = true;
    if (profileFile != null) {
      final res = await _storageRepository.storeFile(
        path: 'communities/profile/',
        id: community.name,
        file: profileFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => community = community.copyWith(avatar: r),
      );
    }
    if (bannerFile != null) {
      final res = await _storageRepository.storeFile(
        id: community.name,
        path: 'communities/banner/',
        file: bannerFile,
      );
      res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => community = community.copyWith(banner: r),
      );
    }

    final res = await _communityRepository.editCommunity(community);
    state = false;
    res.fold((l) => showSnackBar(context, l.message),
        (r) => Routemaster.of(context).pop);
  }

  Stream<List<Community>> searchCommunity(String query) {
    return _communityRepository.searchCommunity(query);
  }

  Future<void> addMods(
      String communityName, List<String> uids, BuildContext context) async {
    try {
      final communityRef = FirebaseFirestore.instance
          .collection('communities')
          .doc(communityName);
      final communityDoc = await communityRef.get();

      if (!communityDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Community does not exist.'),
          ),
        );
        return;
      }


      final currentMods = List<String>.from(communityDoc['mods'] ?? []);
      final newMods = uids.where((uid) => !currentMods.contains(uid)).toList();
      currentMods.addAll(newMods);

      await communityRef.update({
        'mods': currentMods,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Moderators added successfully.'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding moderators: $error'),
        ),
      );
    }
  }

  Stream<List<Post>> getCommunityPosts(String name) {
    return _communityRepository.getCommunityPosts(name);
  }
}
