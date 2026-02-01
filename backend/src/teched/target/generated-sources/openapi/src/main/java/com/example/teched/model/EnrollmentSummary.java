package com.example.teched.model;

import java.net.URI;
import java.util.Objects;
import com.example.teched.model.EnrollmentSummaryCourse;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;
import org.springframework.format.annotation.DateTimeFormat;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

/**
 * EnrollmentSummary
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2026-01-29T22:37:12.278941+01:00[Europe/Rome]")
public class EnrollmentSummary {

  private UUID id;

  private EnrollmentSummaryCourse course;

  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
  private OffsetDateTime enrolledAt;

  private BigDecimal overallProgress;

  public EnrollmentSummary id(UUID id) {
    this.id = id;
    return this;
  }

  /**
   * Get id
   * @return id
  */
  @Valid 
  @Schema(name = "id", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("id")
  public UUID getId() {
    return id;
  }

  public void setId(UUID id) {
    this.id = id;
  }

  public EnrollmentSummary course(EnrollmentSummaryCourse course) {
    this.course = course;
    return this;
  }

  /**
   * Get course
   * @return course
  */
  @Valid 
  @Schema(name = "course", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("course")
  public EnrollmentSummaryCourse getCourse() {
    return course;
  }

  public void setCourse(EnrollmentSummaryCourse course) {
    this.course = course;
  }

  public EnrollmentSummary enrolledAt(OffsetDateTime enrolledAt) {
    this.enrolledAt = enrolledAt;
    return this;
  }

  /**
   * Get enrolledAt
   * @return enrolledAt
  */
  @Valid 
  @Schema(name = "enrolledAt", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("enrolledAt")
  public OffsetDateTime getEnrolledAt() {
    return enrolledAt;
  }

  public void setEnrolledAt(OffsetDateTime enrolledAt) {
    this.enrolledAt = enrolledAt;
  }

  public EnrollmentSummary overallProgress(BigDecimal overallProgress) {
    this.overallProgress = overallProgress;
    return this;
  }

  /**
   * Get overallProgress
   * @return overallProgress
  */
  @Valid 
  @Schema(name = "overallProgress", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("overallProgress")
  public BigDecimal getOverallProgress() {
    return overallProgress;
  }

  public void setOverallProgress(BigDecimal overallProgress) {
    this.overallProgress = overallProgress;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    EnrollmentSummary enrollmentSummary = (EnrollmentSummary) o;
    return Objects.equals(this.id, enrollmentSummary.id) &&
        Objects.equals(this.course, enrollmentSummary.course) &&
        Objects.equals(this.enrolledAt, enrollmentSummary.enrolledAt) &&
        Objects.equals(this.overallProgress, enrollmentSummary.overallProgress);
  }

  @Override
  public int hashCode() {
    return Objects.hash(id, course, enrolledAt, overallProgress);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class EnrollmentSummary {\n");
    sb.append("    id: ").append(toIndentedString(id)).append("\n");
    sb.append("    course: ").append(toIndentedString(course)).append("\n");
    sb.append("    enrolledAt: ").append(toIndentedString(enrolledAt)).append("\n");
    sb.append("    overallProgress: ").append(toIndentedString(overallProgress)).append("\n");
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

