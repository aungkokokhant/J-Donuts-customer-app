import 'package:drift/drift.dart';

import '../../../core/data/app_database.dart';
import '../../../core/data/local_member.dart';
import '../../../core/data/read_local.dart';
import '../../../core/domain/member_profile.dart';
import '../../../core/domain/result.dart';
import '../domain/rewards_repository.dart';

final class LocalRewardsRepository implements RewardsRepository {
  const LocalRewardsRepository(this._db);

  final AppDatabase _db;

  @override
  Future<Result<MemberProfile?>> loadMember(String id) =>
      readLocal(() => loadLocalMember(_db, id));

  @override
  Future<Result<List<RewardChallenge>>> loadChallenges(String memberId) =>
      readLocal(() async {
        final query = _db.select(_db.challenges)
          ..where((row) => row.memberId.equals(memberId))
          ..orderBy([(row) => OrderingTerm.asc(row.position)]);
        return List.unmodifiable(
          (await query.get()).map(
            (row) => (
              id: row.id,
              title: row.title,
              kind: ChallengeKind.values.byName(row.kind),
              completed: row.completed,
              target: row.target,
              points: row.points,
              imageKey: row.imageKey,
            ),
          ),
        );
      });
}
