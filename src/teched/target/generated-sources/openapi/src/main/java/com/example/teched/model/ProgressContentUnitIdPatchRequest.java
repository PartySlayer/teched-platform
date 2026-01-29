package com.example.teched.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.fasterxml.jackson.annotation.JsonValue;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

/**
 * ProgressContentUnitIdPatchRequest
 */

@JsonTypeName("_progress__contentUnitId__patch_request")
@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2026-01-29T22:37:12.278941+01:00[Europe/Rome]")
public class ProgressContentUnitIdPatchRequest {

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

  public ProgressContentUnitIdPatchRequest status(StatusEnum status) {
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

  public ProgressContentUnitIdPatchRequest lastPosition(Integer lastPosition) {
    this.lastPosition = lastPosition;
    return this;
  }

  /**
   * Get lastPosition
   * @return lastPosition
  */
  
  @Schema(name = "lastPosition", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("lastPosition")
  public Integer getLastPosition() {
    return lastPosition;
  }

  public void setLastPosition(Integer lastPosition) {
    this.lastPosition = lastPosition;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    ProgressContentUnitIdPatchRequest progressContentUnitIdPatchRequest = (ProgressContentUnitIdPatchRequest) o;
    return Objects.equals(this.status, progressContentUnitIdPatchRequest.status) &&
        Objects.equals(this.lastPosition, progressContentUnitIdPatchRequest.lastPosition);
  }

  @Override
  public int hashCode() {
    return Objects.hash(status, lastPosition);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class ProgressContentUnitIdPatchRequest {\n");
    sb.append("    status: ").append(toIndentedString(status)).append("\n");
    sb.append("    lastPosition: ").append(toIndentedString(lastPosition)).append("\n");
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

