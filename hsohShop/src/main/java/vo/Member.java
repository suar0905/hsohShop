package vo;

public class Member extends Common {
	// Member테이블 vo
	private int membNo;
	private String membId;
	private String membPw;
	private String membName;
	private int membAge;
	private String membSex;
	private int membLevel;
	
	public int getMembNo() {
		return membNo;
	}
	public void setMembNo(int membNo) {
		this.membNo = membNo;
	}
	
	public String getMembId() {
		return membId;
	}
	public void setMembId(String membId) {
		this.membId = membId;
	}
	
	public String getMembPw() {
		return membPw;
	}
	public void setMembPw(String membPw) {
		this.membPw = membPw;
	}
	
	public String getMembName() {
		return membName;
	}
	public void setMembName(String membName) {
		this.membName = membName;
	}

	public int getMembAge() {
		return membAge;
	}
	public void setMembAge(int membAge) {
		this.membAge = membAge;
	}
	
	public String getMembSex() {
		return membSex;
	}
	public void setMembSex(String membSex) {
		this.membSex = membSex;
	}
	
	public int getMembLevel() {
		return membLevel;
	}
	public void setMembLevel(int membLevel) {
		this.membLevel = membLevel;
	}
	
}
