package com.kh.kh14semi3.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.kh.kh14semi3.mapper.BoardDetailMapper;
import com.kh.kh14semi3.mapper.BoardListMapper;
import com.kh.kh14semi3.vo.PageVO;
import com.kh.kh14semi3.dto.BoardDto;

@Repository
public class BoardDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private BoardListMapper boardListMapper;

    @Autowired
    private BoardDetailMapper boardDetailMapper;

    public int sequence() {
        String sql = "select board_seq.nextval from dual";
        return jdbcTemplate.queryForObject(sql, int.class);
    }

    public void insert(BoardDto boardDto) {
        String sql = "insert into board(BOARD_NO,BOARD_WRITER, "
        		+ "BOARD_TYPE,BOARD_TITLE,BOARD_CONTENT, "
        		+ "BOARD_WTIME,BOARD_VIEWS) "
        		+ "values(?,? ,?, ?, ?, sysdate,?)";
        Object[] data = {
            boardDto.getBoardNo(), boardDto.getBoardWriter(),
            boardDto.getBoardType(),
            boardDto.getBoardTitle(), boardDto.getBoardContent(),
            boardDto.getBoardViews()
        };
        jdbcTemplate.update(sql, data);
    }

    

    public List<BoardDto> selectList(String column, String keyword) {
        String sql = "select BOARD_NO, BOARD_WRITER, BOARD_TYPE,"
        		+ " BOARD_TITLE, BOARD_CONTENT, BOARD_WTIME, "
        		+ "BOARD_UTIME, BOARD_VIEWS "
        		+ "from board where instr(#1, ?) > 0 order by board_no desc";
        sql = sql.replace("#1", column);
        Object[] data = { keyword };
        return jdbcTemplate.query(sql, boardListMapper, data);
    }

    public BoardDto selectOne(int boardNo) {
        String sql = "select * from board where board_no = ?";
        Object[] data = { boardNo };
        List<BoardDto> list = jdbcTemplate.query(sql, boardDetailMapper, data);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean update(BoardDto boardDto) {
        String sql = "update board set board_title=?,"
        		+ " board_content=?, board_utime=sysdate where board_no=?";
        Object[] data = {
            boardDto.getBoardTitle(), boardDto.getBoardContent(),
            boardDto.getBoardNo()
        };
        return jdbcTemplate.update(sql, data) > 0;
    }

    public boolean delete(int boardNo) {
        String sql = "delete from board where board_no=?";
        Object[] data = { boardNo };
        return jdbcTemplate.update(sql, data) > 0;
    }

    public boolean updateBoardViews(int boardNo) {
        String sql = "update board set board_views = board_views + 1 where board_no = ?";
        Object[] data = { boardNo };
        return jdbcTemplate.update(sql, data) > 0;
    }

    public List<BoardDto> selectListByPaging(PageVO pageVO) {
        if (pageVO.isSearch()) {
            String sql = "select * from (select rownum rn, TMP.* from (select BOARD_NO, BOARD_WRITER, BOARD_TYPE, BOARD_TITLE, BOARD_CONTENT, BOARD_WTIME, BOARD_UTIME, BOARD_VIEWS from board where instr(#1, ?) > 0 order by board_no asc) TMP) where rn between ? and ?";
            sql = sql.replace("#1", pageVO.getColumn());

            Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
            return jdbcTemplate.query(sql, boardListMapper, data);
        } else {
            String sql = "select * from (select rownum rn, TMP.* from (select BOARD_NO, BOARD_WRITER, BOARD_TYPE, BOARD_TITLE, BOARD_CONTENT, BOARD_WTIME, BOARD_UTIME, BOARD_VIEWS from board order by board_no asc) TMP) where rn between ? and ?";
            Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
            return jdbcTemplate.query(sql, boardListMapper, data);
        }
    }

    public int countByPaging(PageVO pageVO) {
        if (pageVO.isSearch()) {
            String sql = "select count(*) from board where instr(#1, ?) > 0";
            sql = sql.replace("#1", pageVO.getColumn());
            Object[] data = { pageVO.getKeyword() };
            return jdbcTemplate.queryForObject(sql, int.class, data);
        } else {
            String sql = "select count(*) from board";
            return jdbcTemplate.queryForObject(sql, int.class);
        }
    }

}
