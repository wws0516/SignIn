package signin.entity;

public class Leave {

    public Integer getLeave_id() {
        return leave_id;
    }

    public void setLeave_id(Integer leave_id) {
        this.leave_id = leave_id;
    }

    private Integer leave_id;

    private Integer attendanceId;

    private String reason;

    public Integer getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(Integer attendanceId) {
        this.attendanceId = attendanceId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Override
    public String toString() {
        return "Leave{" +
                "leave_id=" + leave_id +
                ", attendanceId=" + attendanceId +
                ", reason='" + reason + '\'' +
                '}';
    }
}