<?
  //CURL wrapper
  class MyCurl {
    var $ch; //curl handler
    var $cookie_file; //
    var $use_cookie = false;

    //initialisation, setting some headers
    function MyCurl($use_cookie = true) {
     global $debug;
     $this->ch = curl_init() or die("NO CURL!");

     $this->use_cookie = $use_cookie;
     if ($debug) {
       curl_setopt($this->ch, CURLOPT_VERBOSE, 1); //throws debug HTTP coomunications to STDERR
       curl_setopt ($this->ch, CURLOPT_HEADER, 0); //include HTTP header in response or not
     } else curl_setopt($this->ch, CURLOPT_VERBOSE, 0);

     curl_setopt($this->ch, CURLOPT_FOLLOWLOCATION, 0); //automatically redirects from SERVER redirects (HTTP 301/302 response);
     //curl_setopt($this->ch, CURLOPT_AUTOREFERER, 0); //automatically setups referer (check syntax in man)
		 
     curl_setopt($this->ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)");
     curl_setopt($this->ch, CURLOPT_HTTPHEADER, array("Accept-Language: en-us;q=0.5", "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7","Accept-Encoding: gzip,deflate"));
     curl_setopt($this->ch, CURLOPT_ENCODING, 'deflate'); //accept gzipped response - more faster/less traffic
     curl_setopt($this->ch, CURLOPT_RETURNTRANSFER, 1);
     curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, FALSE); //don't validate HTTPs sertificates (correct work with ssl)

     curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT, 55);
     curl_setopt($this->ch, CURLOPT_TIMEOUT, 55);

    /* if ($this->use_cookie) {
			$this->cookie_file = $this->get_curl_cookie_file();
			curl_setopt($this->ch, CURLOPT_COOKIEJAR, $this->cookie_file);
			curl_setopt($this->ch, CURLOPT_COOKIEFILE, $this->cookie_file);     
     }*/
		 
    }


    //implementation of GET method, returns content of page
    function get($url) {
      curl_setopt($this->ch, CURLOPT_URL, $url);
      curl_setopt($this->ch, CURLOPT_HTTPGET, 1);
      return curl_exec($this->ch);
    }

    //implementation of POST method, returns content of page
    //second argument - array of data to send
    function post($url, $vars) {
      //urlencoding data
      $tmp = array();
      foreach ($vars as $k=>$v) $tmp[] = $k.'='.urlencode($v);
      $tmp = implode('&', $tmp);

      curl_setopt($this->ch, CURLOPT_URL, $url);
      curl_setopt($this->ch, CURLOPT_HTTPHEADER, array("Content-Type: application/x-www-form-urlencoded",'Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5'));
      curl_setopt($this->ch, CURLOPT_POST, 1);
      curl_setopt($this->ch, CURLOPT_POSTFIELDS, $tmp);
      return curl_exec($this->ch);
    }
		
		//due to curl restrictions we have to specify FULL path in cookie options
		function get_curl_cookie_file() {
			if (!defined('CURL_COOKIE_DIR')) {
				$cwd = getcwd().'/';
				$cwd = str_replace('\\', '/', $cwd); //win OS
				$cwd = str_replace('//', '/', $cwd);
				define('CURL_COOKIE_DIR', $cwd);
			}
			$cookie_file = CURL_COOKIE_DIR.'curl_cookie'.rand(1,1000).md5(microtime(true)); //randomize name
			if (file_exists($cookie_file)) @unlink($cookie_file); //remove file from previous sessions
			return $cookie_file;
		}
		
  }

?>