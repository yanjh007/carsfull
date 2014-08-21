<?php
class Client extends CI_Model {
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql="SELECT id,name,mobile,wechat FROM clients" ;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' or mobile like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by edit_at desc limit 20";

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
  
  
  public function link($client) {
    $car_number = $client["carnumber"];
	if (isset($car_number) ) {
      $query = $this->db->query("SELECT id FROM cars where carnumber ='".$car_number."' limit 1");
      if($query ->num_rows() > 0) {
        $car_id = $query->row()->id;
        
        $query = $this->db->query("SELECT 1 FROM links where ltype=1 and lid = ".$client["client_id"]." and rid=".$car_id." limit 1");  
        if($query -> num_rows() == 0) {
          $data = array(
                 'ltype'  => '1',
                 'lid'    => $client["client_id"],
                 'lname'  => $client["client_name"],
                 'rid'    => $car_id,
                 'rname'  => $car_number,
                );
          $this->db->insert('links', $data); 
          return TRUE;
        }         
      }
	}
    return NULL;
  }
  
  public function get_cars($cid) {
    $sql = "select carnumber,model,modelname,manufacturer,brand from cars where id in (select rid from links where ltype=? and lid=?)";
    //$sql="SELECT rid,rname FROM links where lid = ? and ltype=?";
	
    $query = $this->db->query($sql,"1",$cid);

    if($query -> num_rows() > 0) {
      return $query->result_array();
    } else {
      return NULL;
    }
  }
  
}