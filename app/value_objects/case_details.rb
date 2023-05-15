class CaseDetails < ValueObject
  VALUES = [
    THERE_WAS_AN_ASSIGNED_COUNSEL = new(:assigned_counsel),
    THERE_WAS_AN_UNASSIGNED_COUNSEL = new(:unassigned_counsel),
    THERE_WAS_AN_AGENT_INSTRUCTED = new(:agent_instructed),
    REMITTED_TO_MAGISTRATE = new(:remitted_to_magistrate),
  ].freeze
end
