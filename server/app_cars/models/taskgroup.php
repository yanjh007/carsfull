<?php
Class Taskgroup extends CI_Model {
  const SQLQUERY   = 'SELECT id,name,descp FROM taskgroups ';
  const TABLENAME  = 'taskgroups';
  
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

  public function save($taskgroup) {
    $data = array(
			'name' => $taskgroup["name"],
			'descp' => $taskgroup["descp"],
          );
    
	if (isset($taskgroup["item_id"]) ) { // insert
        $this->db->where('id', $taskgroup["item_id"]);
        $this->db->update(self::TABLENAME, $data); 
	} else {
        $this->db->insert(self::TABLENAME, $data); 
	}
    return TRUE;
  }
  
   public function remove($id) {
    $this->db->where('id', $id);
    $this->db->delete(self::TABLENAME);
	
	$this->load->model('link');
    $this->db->where('ltype',Link::TYPE_TASKGROUP_TASK);
    $this->db->where('lid', $id);
    $this->db->delete('links');
    return TRUE;
  }
  
  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
    return $query->row_array();
  }
  
  public function get_tasks() { //获取任务组相关任务	
	$this->load->model('link');
	$sql = "select lid,rid,rname from links where ltype = ? order by lid,rid";
    $query = $this->db->query($sql,array(Link::TYPE_TASKGROUP_TASK));
    return $query->result_array();
  }

  public function get_tasks1($tgid) { //获取任务组相关任务
	$this->load->model('link');
	$sql = "select rid,rname from links where lid= ? and ltype = ? order by rid";
    $query = $this->db->query($sql,array($tgid,Link::TYPE_TASKGROUP_TASK));
    return $query->result_array();
  }
  
  public function get_tasks2($tgid) { //获取其他任务
	$this->load->model('link');
	$sql = "select id,name from tasktypes where id not in (select rid from links where lid= ? and ltype=?)";
    $query = $this->db->query($sql,array($tgid,Link::TYPE_TASKGROUP_TASK));
    return $query->result_array();
  } 
}
?>
