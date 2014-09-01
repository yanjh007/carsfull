<?php
Class Zmsession extends CI_Model {
  const TABLE_NAME          = 'zm_sessions';
  const SESSION_TYPE_USER   = 1;
  const SESSION_TYPE_CLIENT = 2;
  
  function is_valid($session) {
	$this->load->helper('date');
    
    $stime= date("Y-m-d H:i:s",now());
    $query = $this->db->query("SELECT stime FROM zm_sessions where session_id ='".$session."' and stime > '".$stime."'");

    return $query -> num_rows() > 0 ;
  }
  
  function is_valid_token($session,$client,$device) {
    $query = $this->db->query("SELECT stime FROM zm_sessions where session_id = ? and device_id=?",array($session,$device));

    return $query -> num_rows() > 0 ;
  }
  
  /*
   * 保存seession，返回token
   *
   */
  
  function save($stype,$clientid,$deviceid,$ip) {
	$this->load->library('encrypt');
	$this->load->helper('general');
	$this->load->helper('date');
	
	$hip=$this->hex_ip($ip);
	
	$time = now();
	if ($stype==self::SESSION_TYPE_CLIENT) {
	  $time=$time+365*86400;
	} else {
	  $time=$time+3600;
	}
	
	$stime= date("Y-m-d H:i:s",$time);
	
	$session = $this->encrypt->sha1($stime);
	
	$data = array(
               'session_type' => $stype,
               'session_id'   => $session.$hip,
               'client_id'    => $clientid,
               'device_id'    => $deviceid,
               'stime' => $stime,
            );

	$this->db->insert('zm_sessions', $data);
	return $session;
  }
  
  function hex_ip($ip) {// 转成16进制字符串  
    $ip2="";
    $ary = explode(".",$ip,4);
    for ($i = 0; $i < 4; $i++) {
       $value=$ary[$i];
       if ($value<16) $ip2.="0";
       $ip2.= dechex ($value);
    }   
   return $ip2;
  }
 
}
?>
