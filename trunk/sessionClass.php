<?

class Session{

	protected $db;
	public $uid;
	public $sid;
	public $sid_check = 1;
	
	//---------------------------------------------------------------------------------------------
	function __construct($createSession=1) {
		if($createSession) {
			//TODO: check what the name of the session_id really is...
			//TODO: something that can say how long the session_id should be: this is too arbitrary.
			if($_GET['PHPSESSID'] && strlen($_GET['PHPSESSID']) == 32) {
				session_name($_GET['PHPSESSID']);
			}
			
			//now actually create the session.
			session_start();
		}
		
		//check if there's a uid in the session already.
		//TODO: need a setting somewhere that says what the name of this var should be,
		//	instead of always forcing "uid".
		$this->uid = 0;
		if($_SESSION['uid']) {
			$this->uid = $_SESSION['uid'];
		}
		
		//grab what our session_id is...
		$this->sid = session_id();
		
	}//end __construct()
	//---------------------------------------------------------------------------------------------


}//end content__Session{}
?>