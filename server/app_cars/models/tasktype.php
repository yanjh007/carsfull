<?php
Class Tasktype extends CI_Model {
  const SQLQUERY = 'SELECT id,tcode,name,duration1,duration2,tasktime,taskprice FROM tasktypes ';
  
  public function __construct() {
    $this->load->database();
  }
  
  public function search($keyword = FALSE) {
    $sql=self::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' ";
    }
    
    //$sql= $sql." order by role desc";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function save($tasktype) {
    //var_dump($tasktype);
    
    if ($tasktype["name"]==NULL || $tasktype["name"]=="") $tasktype["name"]="未命名";
    
    
    $data = array(
           'tcode'     => $tasktype["tcode"],
           'name'      => $tasktype["name"],
           'duration1' => $tasktype["duration1"],
           'duration2' => $tasktype["duration2"],
           'tasktime'  => $tasktype["tasktime"],
           'taskprice' => $tasktype["taskprice"],
          );
    
	if (isset($tasktype["tasktype_id"]) ) { // insert
        $this->db->where('id', $tasktype["tasktype_id"]);
        $this->db->update('tasktypes', $data); 
	} else {
        $this->db->insert('tasktypes', $data); 
	}
    return TRUE;
  }
  
  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
    return $query->row_array();
  }
 
  public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete('tasktypes');
	
	$this->load->model('link');
    $this->db->where('ltype',Link::TYPE_TASKGROUP_TASK);
    $this->db->where('rid', $id);
    $this->db->delete('links');
    return TRUE;
  }
 
}
?>
