<?php
class Dic extends CI_Model {
  const SQLQUERY  = 'SELECT id,dtype,did,name FROM dic  ';
  const TABLE_NAME = 'dic';
  
  public function __construct() {
    $this->load->database();
  }

  public function get_list($dtype=FALSE) {
    if($dtype) {
      $sql="select id,did,name,sname,sdesc from dic where dtype='".$dtype."' and did>0 and did<100 order by did " ;
    } else {
      $sql="select id,did,name,sname,sdesc from dic order by dtype,did " ;	  
    }
    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function add_item($dtype,$name,$pos=100){
    if ($pos==100) { //在后部插入
      $sql="select did from ".self::TABLE_NAME." where dtype=".$dtype." and did<100 order by did desc limit 1";
      $query = $this->db->query($sql);
      $did = $query->row()->did+1;
    } else {      
      $sql="UPDATE ".self::TABLE_NAME." set did=did+1 where did>=".$pos." and did<100 and dtype=".$dtype;
      $this->db->query($sql);
      
      $did=$pos;
    }
    
    $data = array(
       'dtype' => $dtype,
       'name'  => $name,
       'did'   => $did,
      );
    $this->db->insert(self::TABLE_NAME, $data);	
  }
  
  
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete(self::TABLE_NAME); 
    return TRUE;
  }

}