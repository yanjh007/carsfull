<?php
class Dic extends CI_Model {
  const DIC_TYPE_ALL		= 0;
  const DIC_TYPE_COURSE		= 10;
  const DIC_LESSON_STATUS	= 11;
  
  const STD_SQL_QUERY  = 'SELECT id,dtype,did,dcode,name FROM dic ';
  const TABLE_NAME = 'dic';
  
  public function __construct() {
    $this->load->database();
  }

  public function get_list($dtype=self::DIC_TYPE_ALL) {
    $sql=self::STD_SQL_QUERY;
    if($dtype==self::DIC_TYPE_ALL) {
      $sql .= " order by dtype,did " ;	  
    } else {
      $sql .= " where dtype='".$dtype."' and did>0 and did<100 order by did " ;
    }
    $query = $this->db->query($sql);
    return $query->result_array();
  }
  
  public function get_select_list($dtype) {
    $sql= "select did,name from ".self::TABLE_NAME." where dtype=".$dtype." and did>0 and did<100 order by did " ;

    $query = $this->db->query($sql);
    $ary=array();
    if ($query->num_rows()>0) foreach ($query->result() as $row) {
	$ary[$row->did]=$row->name;
    }
    return $ary;
  }

  public function get_dic_list($dtype) {
    $sql= "select did id,name value from ".self::TABLE_NAME." where dtype=".$dtype." and did>0 and did<100 order by did " ;

    $query = $this->db->query($sql);
    $ary_dic=array();
    if ($query->num_rows()>0) foreach($query->result() as $row) {
      $ary_dic[$row->id]=$row->value;
    }
    
    return $ary_dic;
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