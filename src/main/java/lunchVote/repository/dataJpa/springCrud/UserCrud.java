package lunchVote.repository.dataJpa.springCrud;

import lunchVote.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserCrud extends JpaRepository<User, Integer>{

    @Query("SELECT DISTINCT user FROM User user JOIN FETCH user.roles WHERE user.email=:email")
    User getByEmail(@Param("email")String email);

    @Modifying
    @Query("DELETE FROM User WHERE id=:id")
    int delete(@Param("id") int id);
}