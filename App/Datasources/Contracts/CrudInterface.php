<?php

namespace App\Datasources\Contracts;

interface CrudInterface
{
    public function create(array $payload, $params = []): bool;
    public function read(array $query, $filter = []): mixed;
    public function update(array $where, array $mixedPayload): bool;
    public function delete(array $where, $params = []): bool;
}
