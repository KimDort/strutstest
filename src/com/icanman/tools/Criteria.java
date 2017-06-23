package com.icanman.tools;

public class Criteria {
	private int page;
	private int perPageNum;
	/* oracle pagein */
	private int pageEnd;

	public Criteria() {
		this.page = 1;
		this.perPageNum = 12;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 12;
		}
		this.perPageNum = perPageNum;
	}

	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public int getPageEnd() {
		return (this.page) * perPageNum;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}
}
