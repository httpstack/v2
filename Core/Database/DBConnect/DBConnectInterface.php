<?php

namespace Core\Database\DBConnect;

interface DBConnectInterface
{
    /** Create instance from environment variables */
    public static function createFromEnv(): DBConnectInterface;

    /** Return underlying PDO instance (or $this) */
    public function getPdo(): \PDO;

    /** Execute SELECT and return all rows (assoc) */
    public function fetchAll(string $sql, array $params = []): array;

    /** Execute SELECT and return single row or null */
    public function fetchOne(string $sql, array $params = []): ?array;

    /** Execute INSERT/UPDATE/DELETE. Returns affected rows. */
    public function execute(string $sql, array $params = []): int;

    /** Return last insert id (string per PDO) */
    public function lastInsertId(): string;

    /** Close connection / cleanup (best-effort) */
    public function close(): void;
}
