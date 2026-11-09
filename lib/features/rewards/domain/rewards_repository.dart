import '../../../core/domain/member_profile.dart';
import '../../../core/domain/result.dart';

enum ChallengeKind { donut, coffee }

typedef RewardChallenge = ({
  String id,
  String title,
  ChallengeKind kind,
  int completed,
  int target,
  int points,
  String imageKey,
});

abstract interface class RewardsRepository {
  Future<Result<MemberProfile?>> loadMember(String id);
  Future<Result<List<RewardChallenge>>> loadChallenges(String memberId);
}
