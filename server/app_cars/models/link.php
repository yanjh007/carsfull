<?php
class Link extends CI_Model {
  const SQLQUERY = 'SELECT id,name,descp FROM link ';
  const TYPE_CLIENT_CARS = 1;
  const TYPE_TASKGROUP_TASK = 2;
  const TYPE_DISHE_CATAS = 10;
  
  public function __construct() {
    $this->load->database();
  }

  public function link($ltype,$lid,$lname,$rid,$rname) {
	$data = array(
			'lname' => $lname,
			'rname' => $rname,
          );

	$sql="select 1 from links where ltype= ".$ltype." and lid=".$lid." and rid=".$rid ;
	$query = $this->db->query($sql);
	if ($query->num_rows()>0) {
		$this->db->update('links', $data, array('ltype' => $ltype,'lid' => $lid,'rid' => $rid));
	} else {
		$data["ltype"]=$ltype;
		$data["lid"]=$lid;
		$data["rid"]=$rid;
        $this->db->insert('links', $data);     
	}
	return TRUE;
  }

  public function unlink($ltype,$lid,$rid){
    $sql="delete from links where ltype= ".$ltype." and lid=".$lid." and rid=".$rid ;
    $query = $this->db->query($sql);
    return TRUE;
  }
  
  public function remove($ltype,$lr,$id){    
	$sql="delete from links where ltype=? and ?=?";
    $query = $this->db->query($sql,$ltype,$lr==0?"lid":"rid",$id);
    return TRUE;
  }
  
  public function rlist($ltype,$lid){
    $sql= "select rid,rname from links where ltype=".$ltype." and lid= ".$lid;
    $query = $this->db->query($sql);
    if ($query->num_rows()>0) {
      return $query->result_array();
    } else {
      return NULL;
    }
  }
  
  public function llist($ltype,$rid){
    $sql= "select lid,lname from links where ltype=".$ltype." and rid= ".$rid;
    $query = $this->db->query($sql);
    if ($query->num_rows()>0) {
      return $query->result_array();
    } else {
      return NULL;
    }
  }

}