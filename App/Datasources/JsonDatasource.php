<?php

namespace App\Datasources;

use App\Datasources\Contracts\CrudInterface;

class JsonDatasource implements CrudInterface
{
    private bool $readOnly = true;
    private string $filePath;
    private array $data = [];

    public function __construct(string $filePath)
    {
        $this->filePath = $filePath;
        $this->loadData();
    }

    private function loadData(): void
    {
        if (file_exists($this->filePath)) {
            $json = file_get_contents($this->filePath);
            $this->data = json_decode($json, true) ?? [];
        }
    }

    private function saveData(): void
    {
        if ($this->readOnly) {
            throw new \Exception("Datasource is read-only.");
        }
        file_put_contents($this->filePath, json_encode($this->data, JSON_PRETTY_PRINT));
    }

    public function setReadOnly(bool $readOnly): void
    {
        $this->readOnly = $readOnly;
    }

    public function isReadOnly(): bool
    {
        return $this->readOnly;
    }

    public function create(array $payload, $params = []): bool
    {
        if ($this->readOnly) {
            throw new \Exception("Datasource is read-only.");
        }
        $newArray = array_intersect(
            array_keys($payload),
            array_keys($this->data[count($this->data)])
        );

        $this->data[] = $newArray;
        $this->saveData();
        return true;
    }

    public function read(array $query, $filter = []): mixed
    {
        // Simple filtering logic based on query keys and values
        return array_filter($this->data, function ($item) use ($query) {
            foreach ($query as $key => $value) {
                if (!isset($item[$key]) || $item[$key] != $value) {
                    return false;
                }
            }
            return true;
        });
    }

    public function update(array $where, array $mixedPayload): bool
    {
        if ($this->readOnly) {
            throw new \Exception("Datasource is read-only.");
        }
        foreach ($this->data as &$item) {
            foreach ($where as $key => $value) {
                if (isset($item[$key]) && $item[$key] == $value) {
                    $item = array_merge($item, $mixedPayload);
                }
            }
        }
        unset($item); // Break reference
        $this->saveData();
        return true;
    }

    public function delete(array $where, $params = []): bool
    {
        if ($this->readOnly) {
            throw new \Exception("Datasource is read-only.");
        }
        $this->data = array_filter($this->data, function ($item) use ($where) {
            foreach ($where as $key => $value) {
                if (isset($item[$key]) && $item[$key] == $value) {
                    return false; // Exclude this item
                }
            }
            return true; // Keep this item
        });
        $this->saveData();
        return true;
    }
}
