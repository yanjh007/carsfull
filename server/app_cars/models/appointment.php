<?php
Class Appointment extends CI_Model {
  const SQLQUERY = 'SELECT id,client,car,atime,status FROM appointments ';
  
  public function __construct() {
    $this->load->database();
  }
  
  public function search($keyword = FALSE) {
    $sql=self::SQLQUERY;
    if ($keyword) {
      //$sql=$sql." where name like '%".$keyword."%' ";
    }
    
    //$sql= $sql." order by role desc";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function save($item) {
    //var_dump($tasktype);    
    $data = array(
           'client'     => $item["client"],
           'car'      => $item["car"],
           'duration1' => $item["atime"],
          );
    
	if (isset($item["item_id"]) ) { // insert
        $this->db->where('id', $item["item_id"]);
        $this->db->update('appoiontments', $data); 
	} else {
        $this->db->insert('appoiontments', $data); 
	}
    return TRUE;
  }
  
  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
    return $query->row_array();
  }
 
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete('appoiontments');
	
	//$this->load->model('link');
    //$this->db->where('ltype',Link::TYPE_TASKGROUP_TASK);
    //$this->db->where('rid', $id);
    //$this->db->delete('links');
    return TRUE;
  }
 
}
?>
