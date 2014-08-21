<?php
Class User extends CI_Model {
  //const SQLQUERY = 'SELECT id,login,name,role,passwd,mobile,address,shop FROM users ';
  const SQLQUERY ="SELECT U.id,login,U.name,role,passwd,mobile,U.address,shop,S.name shopname FROM users U left JOIN shops S ON shop=S.id";
  
  public function __construct() {
    $this->load->database();
  }
  
  function get_user_by_login($login) {
      $query = $this->db->query(self::SQLQUERY. " where login ='".$login."' limit 1");

      if($query -> num_rows() == 1) {
         return $query->row();
      } else {
         return NULL;
      }
  }
  
  public function search($keyword = FALSE) {
    $sql=self::SQLQUERY;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by role desc";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  
  public function get_one($id){
    $query = $this->db->query(self::SQLQUERY." where U.id= ?",$id);
    return $query->row_array();
  }
  
  public function save($item) {
    //var_dump($item);
    
  //  if ($item["name"]==NULL || $item["name"]=="") $item["name"]="未命名";
    
    $data = array(
           'login'     => $item["login"],
           'name'      => $item["name"],
           'mobile' => $item["mobile"],
           'address' => $item["address"],
           'shop' => $item["shop"],
           'role' => $item["role"],
          );
    
	if (isset($item["item_id"]) ) { // insert
        $this->db->where('id', $item["item_id"]);
        $this->db->update('users', $data); 
	} else {
        $this->db->insert('users', $data); 
	}
    return TRUE;
  }
  
  public function role_list() {
    return array(
                 "100:管理员",
                 "0:店员"
                 );
  
  }
  
  public function role_names() {
    return array(
                 "100"=>"管理员",
                 "0"=>"店员"
                 );
  
  }
    
}