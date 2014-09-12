<?php
class Client extends CI_Model {
  const SQLQUERY   = "SELECT id,name,mobile,wechat,contact,address,passwd FROM clients";
  const TABLE_NAME = "clients";
  
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
  
  public function get_by_login($login) {
    $query = $this->db->query(self::SQLQUERY." where login=? or mobile=? limit 1",array($login,$login));      
    return  ($query -> num_rows() > 0)?$query->row_array():NULL;
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
  
  // 登录接口 login，getcode,recover
  /* 登录接口状态
   * 1-新用户创建并登录 2-已有用户正常登录 3-密码验证恢复登录
   * 11-新用户通知 12-已有用户生成验证码 13　
   * 21－密码错误 22-提交错误 23-验证码错误
  
  */
  public function if_login() { //client登录服务接口 客户端提交sha1(password)+username 服务器响应session和错误
	$hash  = $this->input->get_post('H');
	if ($hash) { // Post
   		$login    = substr($hash,40);
		$passwd   = substr($hash,0,40);
		$device= $this->input->get_post('I');
		
		$this->load->model('zmsession');
		
		$client= $this->get_by_login($login);
		if ($client) { //有记录，验证密码和Device
		  if ($client["passwd"]==$passwd) {
			// Token
			$token = $this->zmsession->save(Zmsession::SESSION_TYPE_CLIENT,$login,$device,$this->input->ip_address());
			
			// 客户信息
			$info=array();
			if ($client["name"]) 	$info["name"]	=$client["name"];
			if ($client["contact"]) $info["contact"]=$client["contact"];
			if ($client["name"]) 	$info["address"]=$client["address"];
			
			// 客户车辆信息
			$this->load->model("car");
			$cars= $this->car->get_cars_list();
			
			$data["content"] = json_encode(array("status"=>2,"token"=>$token,"cid"=>$client["id"],"info"=>$info,"cars"=>$cars));
		  } else {
			$data["result"] = "FALSE";
			$data["content"] = json_encode(array("status"=>21,"error"=>"密码错误"));
		  }
		} else { //无记录，新用户
		  $this->client->add($login,$passwd,$device);
		  $token = $this->zmsession->save(Zmsession::SESSION_TYPE_CLIENT,$login,$device,$this->input->ip_address());
		  $cid= $this->client->get_id_by_login($login);
		  $data["content"] = json_encode(array("status"=>1,"token"=>$token,"cid"=>$cid));
		}	  
	} else {
	  $data["result"] = "FALSE";
	  $data["content"] = json_encode(array("status"=>22,"error"=>"数据交付格式错误"));
	}
	return $data;
  }
  
  public function if_getcode() { //验证码获取接口
	$login  = $this->input->get_post('login');
	if ($login) { // Post
	    $device= $this->input->get_post('I');
	    
	    $vcode= $this->gen_vcode($login);
	    if ($vcode>0) { //有记录，生成验证码
	      $data["content"] = json_encode(array("status"=>12,"vcode"=>$vcode));
	    } else { //无记录，可能是新用户
	      $data["content"] = json_encode(array("status"=>11));
	    }	  
	} else {
	    $data["result"]="FALSE"; //数据交付格式错误
	    $data["content"] = json_encode(array("status"=>22,"error"=>"数据提交格式错误"));
	}
	return $data;
  }
  
  public function if_recover() { //密码恢复接口
	$hash  = $this->input->get_post('H');
	if ($hash) { // Post
		$passwd   = substr($hash,0,40);
   		$vcode    = substr($hash,40,6);
		$login    = substr($hash,46);
		$device= $this->input->get_post('I');

		$r=$this->vsave($login,$passwd,$vcode) ;
		if ($r==10) { //正常验证，保存
		  $this->load->model('zmsession');	
		  $token = $this->zmsession->save(Zmsession::SESSION_TYPE_CLIENT,$login,$device,$this->input->ip_address());
		  $cid= $this->client->get_id_by_login($login);
		  
		  $data["content"] = json_encode(array("status"=>3,"token"=>$token,"cid"=>$cid));
		} else if ($r==1) { //验证码匹配错误
		  $data["result"]="FALSE"; 
		  $data["content"] = json_encode(array("status"=>23,"error"=>"验证码错误"));		  
		} else if ($r==2) { //验证码超时错误
		  $data["result"]="FALSE"; 
		  $data["content"] = json_encode(array("status"=>24,"error"=>"验证码过期"));		  
		} else { //其他错误
		  $data["result"]="FALSE"; 
		  $data["content"] = json_encode(array("status"=>29,"error"=>"未知错误"));		  
		}
	} else {
	  $data["result"]="FALSE"; //数据交付格式错误
	  $data["content"] = json_encode(array("status"=>22,"error"=>"数据提交格式错误"));
	}
	return $data;
  }
  
  public function if_update() { //资料更新接口
      $content  = $this->input->get_post('C');
      if ($content) { // Post
	  $client = json_decode($content);
	  var_dump($client);
	  if ($client) {
	    $clientid= $this->input->get_post('U');    
	    $data = array(
		   //'wechat' => $client["im"],
		   'name'    => $client->name,
		   'address' => $client->address,
		   'contact' => $client->contact,
		  );
	    $this->db->where('id', $clientid);
	    $this->db->update(self::TABLE_NAME, $data); 

	    $data["content"] = json_encode(array("status"=>1));	
	  } else {
	    $data["result"]="FALSE"; //数据交付格式错误
	    $data["content"] = json_encode(array("status"=>22,"error"=>"数据提交格式错误"));		    
	  }
      } else {
	$data["result"]="FALSE"; //数据交付格式错误
	$data["content"] = json_encode(array("status"=>21,"error"=>"数据为空"));	
      }
      return $data;
  }  
}