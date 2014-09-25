<?php
require('link.php');

class Slink extends Link {
  const TABLE_NAME = 'slinks';
  
  const TYPE_CLASS_ADMIN   = 101;
  const TYPE_CLASS_TEACHER = 102;
  const TYPE_CLASS_STUDENT = 103;
  
  public function __construct() {
    parent::__construct();
  }
  
  public function _get_table() {
    return self::TABLE_NAME;
  }
}