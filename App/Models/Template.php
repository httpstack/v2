<?php

namespace App\Models;

use App\Datasources\Contracts\CrudInterface;
use Core\Model\AbstractModel;

class Template extends AbstractModel
{
    public function __construct(CrudInterface $datasource)
    {
        parent::__construct($datasource);
    }

    public function create($arr, $params = [])
    {
        $this->datasource->create($arr, $params);
    }
}
