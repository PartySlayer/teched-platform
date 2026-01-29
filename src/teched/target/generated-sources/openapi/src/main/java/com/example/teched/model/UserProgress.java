package com.example.teched.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;
import java.time.OffsetDateTime;
import org.springframework.format.annotation.DateTimeFormat;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

/**
 * UserProgress
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2026-01-29T22:37:12.278941+01:00[Europe/Rome]")
public class UserProgress {

  /**
   * Gets or Sets status
   */
  public enum StatusEnum {
    NOT_STARTED("not_started"),
    
    IN_PROGRESS("in_progress"),
    
    COMPLETED("completed");

    private String value;

    StatusEnum(String value) {
      this.value = value;
    }

    @JsonValue
    public String getValue() {
      return value;
    }

    @Override
    public String toString() {
      return String.valueOf(value);
    }

    @JsonCreator
    public static StatusEnum fromValue(String value) {
      for (StatusEnum b : StatusEnum.values()) {
        if (b.value.equals(value)) {
          return b;
        }
      }
      throw new IllegalArgumentException("Unexpected value '" + value + "'");
    }
  }

  private StatusEnum status;

  private Integer lastPosition;

  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
  private OffsetDateTime updatedAt;

  public UserProgress status(StatusEnum status) {
    this.status = status;
    return this;
  }

  /**
   * Get status
   * @return status
  */
  
  @Schema(name = "status", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("status")
  public StatusEnum getStatus() {
    return status;
  }

  public void setStatus(StatusEnum status) {
    this.status = status;
  }

  public UserProgress lastPosition(Integer lastPosition) {
    this.lastPosition = lastPosition;
    return this;
  }

  /**
   * Secondi nel video
   * @return lastPosition
  */
  
  @Schema(name = "lastPosition", description = "Secondi nel video", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("lastPosition")
  public Integer getLastPosition() {
    return lastPosition;
  }

  public void setLastPosition(Integer lastPosition) {
    this.lastPosition = lastPosition;
  }

  public UserProgress updatedAt(OffsetDateTime updatedAt) {
    this.updatedAt = updatedAt;
    return this;
  }

  /**
   * Get updatedAt
   * @return updatedAt
  */
  @Valid 
  @Schema(name = "updatedAt", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("updatedAt")
  public OffsetDateTime getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(OffsetDateTime updatedAt) {
    this.updatedAt = updatedAt;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    UserProgress userProgress = (UserProgress) o;
    return Objects.equals(this.status, userProgress.status) &&
        Objects.equals(this.lastPosition, userProgress.lastPosition) &&
        Objects.equals(this.updatedAt, userProgress.updatedAt);
  }

  @Override
  public int hashCode() {
    return Objects.hash(status, lastPosition, updatedAt);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class UserProgress {\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
    sb.append("    lastPosition: ").append(toIndentedString(lastPosition)).append("\n");
    sb.append("    updatedAt: ").append(toIndentedString(updatedAt)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}

