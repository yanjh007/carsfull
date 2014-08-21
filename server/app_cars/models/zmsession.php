<?php
Class Zmsession extends CI_Model {
  function is_valid($session) {
	$this->load->helper('date');
    
    $stime= date("Y-m-d H:i:s",now());
    $query = $this->db->query("SELECT stime FROM zm_sessions where session_id ='".$session."' and stime > '".$stime."'");

    return $query -> num_rows() > 0 ;
  }
  
  function save($stype,$clientid,$deviceid,$ip) {
	$this->load->library('encrypt');
	$this->load->helper('general');
	$this->load->helper('date');
	
	$hip=$this->hex_ip($ip);
	
	$time = now()+3600;
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
