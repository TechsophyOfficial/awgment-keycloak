package com.techsophy.awgment.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import static com.techsophy.awgment.dto.MessageConstant.*;

@Getter
@Setter
@Builder
public class UserRequestPayload {
    @NotNull(message = USER_NAME_NOT_NULL) String userName;
    @NotBlank(message = USER_FIRST_NAME_NOT_BLANK) String firstName;
    @NotBlank(message = USER_LAST_NAME_NOT_BLANK) String lastName;
    @NotBlank(message = MOBILE_NUMBER_NOT_BLANK) String mobileNumber;
    @NotBlank(message = EMAIL_ID_NOT_BLANK) String emailId;
    @NotBlank(message = DEPARTMENT_NAME_NOT_BLANK) String department;
}
