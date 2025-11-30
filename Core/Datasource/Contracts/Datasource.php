<?php

namespace Core\Datasource\Contracts;

interface Datasource
{
    // This class assumes you have a instance property called readOnly
    // this property should default to true.

    /**
     * Set the read-only status of the datasource.
     *
     * @param bool $readOnly
     * @return void
     */
    public function setReadOnly(bool $readOnly): void;

    /**
     * Check if the datasource is read-only.
     *
     * @return bool
     */
    public function isReadOnly(): bool;
}
