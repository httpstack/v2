<?php

namespace Core\Database\DBConnect;

use PDO;
use PDOException;
use RuntimeException;
use Core\Database\DBConnect\DBConnectInterface;

class DBConnect extends PDO implements DBConnectInterface
{

    protected array $config = [];
    public function __construct()
    {
        $this->config['DB_DRIVER'] = "mysql";
        $this->config['DB_HOST'] = "localhost";
        $this->config['DB_PORT'] = "3306";
        $this->config['DB_DB'] = "httpstack";
        $this->config['DB_USER'] = "http_user";
        $this->config['DB_PASS'] = "bf6912";
        $this->config['DB_CHARSET'] = "utf8mb4";
        $dsn = sprintf(
            '%s:host=%s;port=%s;dbname=%s;charset=%s',
            $this->config['DB_DRIVER'],
            $this->config['DB_HOST'],
            $this->config['DB_PORT'],
            $this->config['DB_DB'],
            $this->config['DB_CHARSET']
        );
        parent::__construct($dsn, $this->config['DB_USER'], $this->config['DB_PASS']);
        $this->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $this->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        $this->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
    }

    // This factory method remains the same, but now correctly works with the new constructor.
    public static function createFromEnv(): DBConnectInterface
    {
        $driver = getenv('DB_DRIVER') ?: 'mysql';

        try {
            if ($driver === 'sqlite') {
                $path = getenv('DB_PATH') ?: __DIR__ . '/../../../../storage/database.sqlite';
                $dir = dirname($path);
                if (!is_dir($dir)) @mkdir($dir, 0755, true);
                $dsn = 'sqlite:' . $path;
                new PDO($dsn);
            } else {
                $host = getenv('DB_HOST') ?: 'localhost';
                $port = getenv('DB_PORT') ?: '3306';
                $name = getenv('DB_NAME') ?: 'cmcintosh';
                $user = getenv('DB_USER') ?: 'http_user';
                $pass = getenv('DB_PASS') ?: 'bf6912';
                $charset = getenv('DB_CHARSET') ?: 'utf8mb4';
                $dsn = sprintf('%s:host=%s;port=%s;dbname=%s;charset=%s', $driver, $host, $port, $name, $charset);
                new PDO($dsn, $user, $pass);
            }

            return new self();
        } catch (PDOException $e) {
            throw new RuntimeException('DB connect failed: ' . $e->getMessage(), (int)$e->getCode(), $e);
        }
    }

    public function getPdo(): PDO
    {
        return $this;
    }

    public function fetchAll(string $sql, array $params = []): array
    {
        try {
            if (empty($params)) {
                $stmt = $this->query($sql);
                if ($stmt === false) return [];
                return $stmt->fetchAll();
            }
            $stmt = $this->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchAll();
        } catch (PDOException $e) {
            throw new RuntimeException('fetchAll error: ' . $e->getMessage(), (int)$e->getCode(), $e);
        }
    }

    public function fetchOne(string $sql, array $params = []): ?array
    {
        $rows = $this->fetchAll($sql, $params);
        return $rows[0] ?? null;
    }

    public function execute(string $sql, array $params = []): int
    {
        try {
            if (empty($params)) {
                $res = $this->exec($sql);
                return $res === false ? 0 : (int)$res;
            }
            $stmt = $this->prepare($sql);
            $stmt->execute($params);
            return (int)$stmt->rowCount();
        } catch (PDOException $e) {
            throw new RuntimeException('execute error: ' . $e->getMessage(), (int)$e->getCode(), $e);
        }
    }
}

$dbconn = new DBConnect();
