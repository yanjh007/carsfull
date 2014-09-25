<?php
class Link extends CI_Model {
  const TABLE_NAME = 'links';
  
  const TYPE_CLIENT_CARS = 1;
  const TYPE_TASKGROUP_TASK = 2;
  const TYPE_DISHE_CATAS = 10;
  const TYPE_DISHE_SETS  = 11;
  
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
	    $this->db->update($this->_get_table(), $data, array('ltype' => $ltype,'lid' => $lid,'rid' => $rid));
    } else {
	    $data["ltype"]=$ltype;
	    $data["lid"]=$lid;
	    $data["rid"]=$rid;
    $this->db->insert($this->_get_table(), $data);     
    }
    return TRUE;
  }

  /*
   * 取消链接，可指定清除lid (rid设为0), rid(lid设为0), 或者指定特定的lid和rid
   */
  public function unlink($ltype,$lid,$rid){
    $sql= "delete from ".$this->_get_table();
    if ($rid==0) {
      $sql .= " where ltype= ".$ltype." and lid=".$lid ;      
    } else if ($lid==0) {
      $sql .= " where ltype= ".$ltype." and rid=".$rid;      
    } else {
      $sql .= " where ltype= ".$ltype." and lid=".$lid." and rid=".$rid ;      
    }
    $query = $this->db->query($sql);
    return TRUE;
  }
  
  //获取右侧列表
  public function rlist($ltype,$lid){
    $sql= "select rid,rname from  ".$this->_get_table()."  where ltype=".$ltype." and lid= ".$lid;
    $query = $this->db->query($sql);
    if ($query->num_rows()>0) {
      return $query->result_array();
    } else {
      return NULL;
    }
  }
  
  // 获取左侧列表
  public function llist($ltype,$rid){
    $sql= "select lid,lname from ".$this->_get_table()." where ltype=".$ltype." and rid= ".$rid;
    $query = $this->db->query($sql);
    if ($query->num_rows()>0) {
      return $query->result_array();
    } else {
      return NULL;
    }
  }
  
  /*
   * 设置和更新左右项名称
   */
  public function setlname($ltype,$lid,$lname){
    $this->db->update($this->_get_table(), array("lname"=>$lname),array('ltype' => $ltype,'lid' => $lid));
  }
  
  public function setrname($ltype,$rid,$rname){
    $this->db->update($this->_get_table(), array("rname"=>$rname),array('ltype' => $ltype,'rid' => $rid));
  }
  
  public function _get_table() {
    return self::TABLE_NAME;
  }
}