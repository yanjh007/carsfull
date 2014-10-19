<?php
Class Question extends CI_Model {
  const TABLE_NAME = 'questions';
  const STD_SQL_QUERY  = "SELECT id,qcode,subject,qtype,title,substring(content,1,8) content,qoption,grade,difficulty,status,edit_at FROM questions ";
  
  public function __construct() {
    $this->load->database();
  }
  
  public function search($stype,$keyword = FALSE) {
    $sql=self::STD_SQL_QUERY;
	if($stype==0) { //code，标题
	  if ($keyword) {
		$sql=$sql." where name like '%".$keyword."%' ";
	  }	  
	} else if ($stype==1) { //科目
	  
	} else if ($stype==2) {
	  
	}
	
    $sql= $sql." order by edit_at desc";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_one($id){
    $query = $this->db->query(self::STD_SQL_QUERY." where id=?",$id);
    return $query->row_array();
  }
  
  public function save($id,$item) {
    $data = array(
           'qcode'     => $item["qcode"],
           'qtype'     => $item["qtype"],
           'subject'   => $item["subject"],
           'title'      => $item["title"],
           'content' => $item["content"],
           'qoption' => $item["qoption"],
           'grade'  => $item["grade"],
           'difficulty' => $item["difficulty"],
           'edit_at' => time()/60,
          );
    
	if ($id==0) { // insert
        $this->db->insert(self::TABLE_NAME, $data);
		$nid=$this->db->insert_id();
	} else {
        $this->db->where('id', $id);
        $this->db->update(self::TABLE_NAME, $data);
		$nid=$id;
	}
    return $id;
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
