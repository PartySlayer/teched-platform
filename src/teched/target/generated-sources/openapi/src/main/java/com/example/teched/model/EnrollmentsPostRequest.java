package com.example.teched.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonTypeName;
import java.util.UUID;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

/**
 * EnrollmentsPostRequest
 */

@JsonTypeName("_enrollments_post_request")
@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2026-01-29T22:37:12.278941+01:00[Europe/Rome]")
public class EnrollmentsPostRequest {

  private UUID courseId;

  public EnrollmentsPostRequest courseId(UUID courseId) {
    this.courseId = courseId;
    return this;
  }

  /**
   * Get courseId
   * @return courseId
  */
  @Valid 
  @Schema(name = "courseId", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("courseId")
  public UUID getCourseId() {
    return courseId;
  }

  public void setCourseId(UUID courseId) {
    this.courseId = courseId;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    EnrollmentsPostRequest enrollmentsPostRequest = (EnrollmentsPostRequest) o;
    return Objects.equals(this.courseId, enrollmentsPostRequest.courseId);
  }

  @Override
  public int hashCode() {
    return Objects.hash(courseId);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class EnrollmentsPostRequest {\n");
    sb.append("    courseId: ").append(toIndentedString(courseId)).append("\n");
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

