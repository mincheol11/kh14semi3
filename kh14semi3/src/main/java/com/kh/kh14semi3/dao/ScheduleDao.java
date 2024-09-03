package com.kh.kh14semi3.dao;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.kh.kh14semi3.dto.ScheduleDto;
import com.kh.kh14semi3.mapper.ScheduleDetailMapper;
import com.kh.kh14semi3.mapper.ScheduleListMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class ScheduleDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private ScheduleDetailMapper scheduleDetailMapper;

    @Autowired
    private ScheduleListMapper scheduleListMapper;

    public int sequence() {
        String sql = "select schedule_seq.nextval from dual";
        return jdbcTemplate.queryForObject(sql, int.class);
    }

    public void insert(ScheduleDto scheduleDto) {
        String sql = "insert into schedule"
                + " (schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME) "
                + " values(?, ?, ?, ?, ?, ?)";
        Object[] data = {
            scheduleDto.getScheduleNo(),
            scheduleDto.getScheduleWriter(),
            scheduleDto.getScheduleType(),
            scheduleDto.getScheduleTitle(),
            scheduleDto.getScheduleContent(),
            scheduleDto.getScheduleWtime()
        };
        jdbcTemplate.update(sql, data);
    }

    public ScheduleDto selectOne(int scheduleNo) {
        String sql = "select * from schedule where schedule_no = ?";
        Object[] data = {scheduleNo};
        List<ScheduleDto> list = jdbcTemplate.query(sql, scheduleDetailMapper, data);
        return list.isEmpty() ? null : list.get(0);
    }

    public boolean update(ScheduleDto scheduleDto) {
        String sql = "update schedule set schedule_title=?, schedule_content=?, schedule_wtime=? where schedule_no=?";
        Object[] data = {
            scheduleDto.getScheduleTitle(),
            scheduleDto.getScheduleContent(),
            scheduleDto.getScheduleWtime(),
            scheduleDto.getScheduleNo()
        };
        return jdbcTemplate.update(sql, data) > 0;
    }

    public boolean delete(int scheduleNo) {
        String sql = "delete from schedule where schedule_no=?";
        Object[] data = {scheduleNo};
        return jdbcTemplate.update(sql, data) > 0;
    }

    public List<ScheduleDto> selectListByPaging(PageVO pageVO) {
        int endRow = pageVO.getPage() * pageVO.getSize();
        int beginRow = endRow - (pageVO.getSize() - 1);

        StringBuilder sql = new StringBuilder("select * from ("
                + "select rownum rn, TMP.* from ("
                + "select schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
                + "from schedule");

        if (pageVO.isSearch()) {
            sql.append(" where instr(").append(pageVO.getColumn()).append(", ?) > 0");
        }

        sql.append(" order by schedule_no asc"
                + ") TMP"
                + ") where rn between ? and ?");

        Object[] data;
        if (pageVO.isSearch()) {
            data = new Object[] {pageVO.getKeyword(), beginRow, endRow};
        } else {
            data = new Object[] {beginRow, endRow};
        }

        return jdbcTemplate.query(sql.toString(), scheduleListMapper, data);
    }

    public int countByPaging(PageVO pageVO) {
        StringBuilder sql = new StringBuilder("select count(*) from schedule");

        if (pageVO.isSearch()) {
            sql.append(" where instr(").append(pageVO.getColumn()).append(", ?) > 0");
            return jdbcTemplate.queryForObject(sql.toString(), int.class, pageVO.getKeyword());
        } else {
            return jdbcTemplate.queryForObject(sql.toString(), int.class);
        }
    }

    

    // 날짜 기반 게시글 목록 조회
    public List<ScheduleDto> selectListByDate(java.sql.Date date, int page, int size) {
        int endRow = page * size;
        int beginRow = endRow - (size - 1);

        String sql = "SELECT * FROM ("
                   + "SELECT rownum rn, TMP.* FROM ("
                   + "SELECT schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
                   + "FROM schedule "
                   + "WHERE SCHEDULE_WTIME = ? "
                   + "ORDER BY schedule_no ASC"
                   + ") TMP"
                   + ") WHERE rn BETWEEN ? AND ?";

        Object[] data = {date, beginRow, endRow};
        return jdbcTemplate.query(sql, scheduleListMapper, data);
    }

    // 월 기반 게시글 목록 조회
    public List<ScheduleDto> selectListByMonth(int year, int month, int page, int size) {
        int endRow = page * size;
        int beginRow = endRow - (size - 1);

        String sql = "SELECT * FROM ("
                   + "SELECT rownum rn, TMP.* FROM ("
                   + "SELECT schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
                   + "FROM schedule "
                   + "WHERE EXTRACT(YEAR FROM SCHEDULE_WTIME) = ? AND EXTRACT(MONTH FROM SCHEDULE_WTIME) = ? "
                   + "ORDER BY schedule_no ASC"
                   + ") TMP"
                   + ") WHERE rn BETWEEN ? AND ?";

        Object[] data = {year, month, beginRow, endRow};
        return jdbcTemplate.query(sql, scheduleListMapper, data);
    }

    // 월 기반 게시글 수 카운트
    public int countByMonth(int year, int month) {
        String sql = "SELECT COUNT(*) FROM schedule "
                   + "WHERE EXTRACT(YEAR FROM SCHEDULE_WTIME) = ? AND EXTRACT(MONTH FROM SCHEDULE_WTIME) = ?";
        Object[] data = {year, month};
        return jdbcTemplate.queryForObject(sql, Integer.class, data);
    }

    // 이벤트가 있는 날짜 조회
    public Set<Integer> getEventDaysByMonth(int year, int month) {
        String sql = "SELECT EXTRACT(DAY FROM SCHEDULE_WTIME) AS event_day FROM schedule "
                   + "WHERE EXTRACT(YEAR FROM SCHEDULE_WTIME) = ? AND EXTRACT(MONTH FROM SCHEDULE_WTIME) = ?";

        List<Integer> days = jdbcTemplate.query(sql, (rs, rowNum) -> rs.getInt("event_day"), year, month);
        return new HashSet<>(days); // 날짜를 Set으로 반환하여 중복 제거
    }
}
