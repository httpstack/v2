<?php

namespace Core\Model;

use Core\Model\Concrete\BaseModel;
use App\Datasources\Contracts\CrudInterface;
use Core\Datasource\AbstractDatasource;
use Core\Model\Contracts\AttributeState;

abstract class AbstractModel extends BaseModel
{
    protected array $states = []; // Stack to hold states
    protected CrudInterface $datasource; // The datasource for this model

    public function __construct(CrudInterface $datasource)
    {
        // Initialize the datasource
        parent::__construct($datasource->read());
        $this->datasource = $datasource; // Initialize the datasource
        $this->states = []; // Initialize the states array
    }

    public function pushState(string $nameSpace): mixed
    {
        $this->states[$nameSpace] = $this->getAll();
        return "State pushed: " . $nameSpace;
    }

    public function popState(): array
    {
        $lastKey = array_key_last($this->states);
        if ($lastKey !== null) {
            $lastState = $this->states[$lastKey];
            unset($this->states[$lastKey]);
            $this->setAll($lastState); // Restore the last state
            return $lastState;
        }
        return []; // Return an empty array if no states are available
    }

    public function getState(string $restorePoint): ?array
    {
        return $this->states[$restorePoint] ?? null;
    }

    //REWRITE THE METHODS THAT MUTATE THE MODEL SO THEY PUSH THE STATE
    public function set(string $strKey, mixed $mixValue): void
    {
        $this->pushState("before_set_{$strKey}");
        parent::set($strKey, $mixValue);
    }
    public function remove(string $strKey): void
    {
        $this->pushState("before_remove_{$strKey}");
        parent::remove($strKey);
    }
    public function setAll(array $arrData): void
    {
        $this->pushState("before_setAll");
        parent::setAll($arrData);
    }
    public function clear(): void
    {
        $this->pushState("before_clear");
        parent::clear();
    }
}
