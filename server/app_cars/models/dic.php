<?php
class Dic extends CI_Model {
  public function __construct() {
    $this->load->database();
  }

  public function get_list($dtype=FALSE) {
	if($dtype) {
      $sql="select id,did,name,sname,sdesc from dic where dtype='".$dtype."' and did>0 order by did " ;
	} else {
      $sql="select id,did,name,sname,sdesc from dic order by dtype,did " ;	  
	}
    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_client($cid){
    $sql="SELECT id,name,mobile,wechat FROM clients where id=".$cid ;
    $query = $this->db->query($sql);
    return $query->row_array();
  }
  
  public function save($client) {
	if (isset($client["client_id"]) ) { // insert
        $clientid= $client["client_id"];    
        $data = array(
               'wechat' => $client["im"],
               'name'   => $client["name"],
               'mobile' => $client["mobile"],
              );
        $this->db->where('id', $clientid);
        $this->db->update('clients', $data); 
	} else {
        $data = array(
               'wechat' => $client["im"],
               'name'   => $client["name"],
               'mobile' => $client["mobile"],
              );
        $this->db->insert('clients', $data); 
	}
    return TRUE;
  }
  
  public function remove($client_id) {
    $this->db->where('id', $client_id);
    $this->db->delete('clients'); 
    return TRUE;
  }
  
  function get_passwd_by_login($login) {
    $query = $this->db->query("SELECT passwd FROM clients where login ='".$login."' limit 1");

    if($query -> num_rows() > 0) {
      return $query->row()->passwd;
    } else {
        return NULL;
    }
  }
}