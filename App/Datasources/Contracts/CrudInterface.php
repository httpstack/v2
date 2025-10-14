<?php

namespace App\Datasources\Contracts;

interface CrudInterface
{
    public function create(array $payload): bool;
    public function read(array $query): array;
    public function update(array $query, mixed $payload): bool;
    public function delete(string|int $key): bool;
}
