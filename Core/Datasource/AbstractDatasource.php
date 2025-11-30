<?php

namespace Core\Datasource;

use Core\Datasource\Contracts\CrudInterface;
use Core\Datasource\Contracts\Datasource;

/**
 * Provides a base implementation for datasources.
 *
 * This abstract class handles common datasource functionality like read-only state
 * and provides a contract for CRUD operations that concrete implementations must provide.
 */
abstract class AbstractDatasource implements Datasource, CrudInterface
{
    /**
     * A simple in-memory cache for data read from the datasource to avoid redundant reads.
     * The key is typically a hash or identifier for the query, and the value is the result set.
     *
     * @var array<string, mixed>
     */
    protected array $dataCache = [];

    /**
     * AbstractDatasource constructor.
     *
     * @param bool $readOnly When true, prevents write operations (create, update, delete).
     */
    public function __construct(protected bool $readOnly) {}

    /**
     * Sets the datasource to be read-only or writable.
     *
     * @param bool $readOnly True to make the datasource read-only, false to make it writable.
     * @return void
     */
    public function setReadOnly(bool $readOnly): void
    {
        $this->readOnly = $readOnly;
    }

    /**
     * Checks if the datasource is currently in read-only mode.
     *
     * @return bool True if the datasource is read-only, false otherwise.
     */
    public function isReadOnly(): bool
    {
        return $this->readOnly;
    }

    /**
     * Closes the connection to the datasource and clears any caches.
     *
     * @return mixed Typically returns true on success, but can vary by implementation.
     */
    public function disconnect(): mixed
    {
        // Simulate disconnecting from a data source
        $this->dataCache = [];
        return true;
    }

    /**
     * Creates a new record in the datasource.
     *
     * @param array<string, mixed> $payload The data to be inserted.
     * @param array<string, mixed> $params  Optional parameters for the creation logic.
     * @return bool True on success, false on failure.
     */
    abstract public function create(array $payload, array $params = []): bool;

    /**
     * Reads data from the datasource based on a query.
     *
     * @param array<string, mixed> $query  The query criteria to find records.
     * @param array<string, mixed> $filter Optional filters to apply to the result (e.g., sorting, limits).
     * @return mixed The result set, typically an array of records or a single record.
     */
    abstract public function read(array $query, $filter = []): mixed;

    /**
     * Updates existing records in the datasource.
     *
     * @param array<string, mixed> $where  The criteria to select records to update.
     * @param array<string, mixed> $params The new data for the matching records.
     * @return bool True on success, false on failure.
     */
    abstract public function update(array $where, array $params = []): bool;

    /**
     * Deletes records from the datasource.
     *
     * @param array<string, mixed> $where  The criteria to select records to delete.
     * @param array<string, mixed> $params Optional parameters for the deletion logic.
     * @return bool True on success, false on failure.
     */
    abstract public function delete(array $where, $params = []): bool;
}
