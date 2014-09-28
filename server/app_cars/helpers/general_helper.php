<?php
/*
 * URL helpers, this file extends
 * the current URL helper that
 * CodeIgniter includes.
*/

/**
 * asset_url
 *
 * This function OVERRIDES the current
 * CodeIgniter base_url function to support
 * CDN'ized content.
 */
function hex_ip($ip) // 转成16进制字符串  
{
   $ip2="";
   $ary = explode(".",$ip,4);
   for ($i = 0; $i < 4; $i++) {
      $value=$ary[$i];
      if ($value<16) $ip2.="0";
      $ip2.= dechex ($value);
   }   
   return $ip2;
}

function check_session()
{
   $CI=&get_instance();
   $user = $CI->session->userdata('logged_in'); 

   if (!$user) {
      redirect('/login', 'refresh');
   } 
}

// 显示内容视图
function show_view($viewname,$data,$navid=0) // 转成16进制字符串  
{
   $CI=&get_instance();
      
   $CI->load->view('_common/header');
   show_nav($navid);
   
   $CI->load->view($viewname, $data);
   
   $CI->load->view('_common/footer');	
}

// 导航栏
function show_nav($current_tab)
{   
   $CI=&get_instance();
   $user = $CI->session->userdata('logged_in'); 
   if (!$user) {
      redirect('/login', 'refresh');
   } 

   $navdata['username'] = $user['name']; 
   $navdata['userrole'] = $user['role']; // 将title中的第一个字符大写
   
   $CI->load->helper('url');      
   $CI->load->view('_common/navbar',$navdata);
}

// 时间转化
function date_to_int($dif,$strdate="") // 转成16进制字符串  
{
   if ($strdate=="") {
      
   } else {
      
   }
   
}





