package com.icanman.employee.model;

public class Validate {
	private String focus;
	private String message;
	private Boolean check;
	private int index=0;
	
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public String getFocus() {
		return focus;
	}
	public void setFocus(String focus) {
		this.focus = focus;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Boolean getTrue() {
		return this.check;
	}
	public void setTrue(Boolean isTrue) {
		this.check = isTrue;
	}
	
}
