<?php
class Client extends CI_Model {
  const SQLQUERY  = "SELECT id,name,mobile,wechat,address,passwd FROM clients";
  const TABLENAME = "clients";
  
  public function __construct() {
    $this->load->database();
  }

  public function search($keyword = FALSE) {
    $sql= self::SQLQUERY ;
    if ($keyword) {
      $sql=$sql." where name like '%".$keyword."%' or mobile like '%".$keyword."%' ";
    }
    
    $sql= $sql." order by edit_at desc limit 20";

    $query = $this->db->query($sql);
    return $query->result_array();
  }

  public function get_item($id){
    $query = $this->db->query(self::SQLQUERY." where id=?",$id);
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
  
  public function remove($item_id) {
    $this->db->where('id', $item_id);
    $this->db->delete('clients'); 
    return TRUE;
  }
  
  public function get_passwd_by_login($login) {
    $query = $this->db->query("SELECT passwd FROM clients where login ='".$login."' limit 1");

    if($query -> num_rows() > 0) {
      return $query->row()->passwd;
    } else {
        return NULL;
    }
  }
  
  public function get_id_by_login($login) {
    $query = $this->db->query("SELECT id FROM clients where login = ? limit 1",$login);

    if($query -> num_rows() > 0) {
      return $query->row()->id;
    } else {
      return 0;
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
    $sql = "select carnumber,model,modelname,manufacturer,brand from cars where id in (select rid from links where ltype=1 and lid=".$cid.")";
    //$sql="SELECT rid,rname FROM links where lid = ? and ltype=?";
	
    $query = $this->db->query($sql);

    if($query -> num_rows() > 0) {
      return $query->result_array();
    } else {
      return NULL;
    }
  }
  
  public function add($login,$passwd,$device) {
	$data = array(
	   'passwd' 	=> $passwd,
	   'mobile' 	=> $login,
	   'deviceid' 	=> $device,
	   'login'    	=> $login
	);
    $this->db->insert(self::TABLENAME, $data); 
  }
  
  public function get_by_login($login) {
    $query = $this->db->query(self::SQLQUERY." where login=? or mobile=? limit 1",array($login,$login));
    if($query -> num_rows() > 0) {
      return $query->row_array();
    } else {
      return NULL;
    }
  }
  
  public function gen_vcode($login) {	
	$vcode= rand(100000,999999);
	$data = array(
	   'vcode' 	=> $vcode,
	);
	
	$this->db->set('vtime', 'NOW()', FALSE);
	$this->db->where('login', $login);
	$this->db->update(self::TABLENAME, $data);

	if ($this->db->affected_rows()>0) {
	  return $vcode;  
	} else {
	  return 0;
	}		
  }
  
  // 验证并保存
  public function vsave($login,$passwd,$vcode) {
    $query = $this->db->query("select vcode,UNIX_TIMESTAMP(vtime) vtime from clients where login=? or mobile=? limit 1",array($login,$login));
    if($query -> num_rows() > 0) {
      $row= $query->row_array();
	  if ($row["vcode"]==$vcode) {
		if (time()-$row["vtime"] >600) { //验证码超时		  
		  return 2;
		} else {
		  $this->db->set('passwd', $passwd);
		  $this->db->where('login', $login);
		  $this->db->update(self::TABLENAME);
	  
		  if ($this->db->affected_rows()>0) {
			return 10;  
		  } else {
			return 4; //保存错误
		  }		  
		}
	  } else { //验证码错误
		return 1;
	  }
    } else {
      return 3; //未找到记录
    }
		
  } 
}