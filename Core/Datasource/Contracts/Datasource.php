<?php

namespace Core\Datasource\Contracts;

interface Datasource
{
    public function push(array $attributes): void;
    public function pull(): void;
    public function setReadOnly(bool $readOnly): void;
    public function isReadOnly(): bool;
}
