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




