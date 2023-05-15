class CaseDetails < ValueObject
  VALUES = [
    THERE_WAS_AN_ASSIGNED_COUNSEL = new(:assigned_counsel),
    THERE_WAS_NO_ASSIGNED_COUNSEL = new(:no_assigned_counsel),
    THERE_WAS_AN_UNASSIGNED_COUNSEL = new(:unassigned_counsel),
    THERE_WAS_NO_ASSIGNED_COUNSEL = new(:no_unassigned_counsel),
    THERE_WAS_AN_INSTRUCTED_AGENT = new(:agent_instructed),
    THERE_WAS_NO_INSTRUCTED_AGENT = new(:no_agent_instructed),
  ].freeze
end
