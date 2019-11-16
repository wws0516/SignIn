package signin.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Date;

public class Attendance {

    private Leave leave;

    public Leave getLeave() {
        return leave;
    }

    public void setLeave(Leave leave) {
        this.leave = leave;
    }

    private Integer id;

    private Integer userId;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    public Date getSigntime() {
        return signtime;
    }

    public void setSigntime(Date signtime) {
        this.signtime = signtime;
    }

    private Date signtime;

    private Integer attend;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    private User user;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAttend() {
        return attend;
    }

    public void setAttend(Integer attend) {
        this.attend = attend;
    }

    @Override
    public String toString() {
        return "Attendance{" +
                "id=" + id +
                ", userId=" + userId +
                ", signtime=" + signtime +
                ", attend=" + attend +
                '}';
    }

}