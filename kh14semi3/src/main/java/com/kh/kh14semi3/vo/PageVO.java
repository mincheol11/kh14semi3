package com.kh.kh14semi3.vo;

import lombok.Data;

@Data
public class PageVO {
	private String column;
	private String keyword;
	private int page=1;
	private int size=10;
	private int count;
	private int blockSize = 10;


	public boolean isSearch() {
		
		return this.column != null && this.keyword != null;
	}


	public int getBeginRow() {
		return this.page * this.size - (this.size-1);
	}

	public int getEndRow() {
		return this.page * this.size;
	}

	public int getStartBlock() {
		return (this.page-1) / this.blockSize * this.blockSize + 1;
	}
	public boolean isFirst() {
		return this.getStartBlock() <= 1;
	}
	public boolean hasPrev() {
		return !this.isFirst();
	}
	public int getPrevBlock() {
		return this.getStartBlock()-1;
	}
	public int getLastBlock() {
		return (this.count-1) / this.size+1;
	}
	public int getFinishBlock() {
	int finishBlock = this.getStartBlock() + this.blockSize-1;
	return Math.min(finishBlock, this.getLastBlock());
	}
	public boolean isLast() {
		return this.getFinishBlock() >= this.getLastBlock();
	}
	public boolean hasNext() {
		return this.isLast() == false;
	}
	public int getNextBlock() {
		return this.getFinishBlock() + 1;
	}
	}


