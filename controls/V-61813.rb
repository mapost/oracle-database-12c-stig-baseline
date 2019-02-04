control "V-61813" do
  title "The system must provide an audit log reduction capability."
  desc  "Audit reduction is used to reduce the volume of audit records in order
to facilitate manual review.  Before a security review, information systems
and/or applications with an audit reduction capability may remove many audit
records known to have little security significance.

    This is generally accomplished by removing records generated by specified
classes of events, such as records generated by nightly backups. Audit
reduction does not alter original audit records.

    An audit reduction capability provides support for near real-time audit
review and analysis requirements and after-the-fact investigations of security
incidents.

    The lack of audit reduction in a database can require the DBA, or others
responsible for reviewing audit logs, to sort through large amounts of data in
order to find relevant records. This can cause important audit records to be
missed.
  "
  impact 0.3
  tag "gtitle": "SRG-APP-000113-DB-000053"
  tag "gid": "V-61813"
  tag "rid": "SV-76303r1_rule"
  tag "stig_id": "O121-C3-008700"
  tag "fix_id": "F-67729r1_fix"
  tag "cci": ["CCI-001875"]
  tag "nist": ["Rev_4"]
  tag "false_negatives": nil
  tag "false_positives": nil
  tag "documentable": false
  tag "mitigations": nil
  tag "severity_override_guidance": false
  tag "potential_impacts": nil
  tag "third_party_tools": nil
  tag "mitigation_controls": nil
  tag "responsibility": nil
  tag "ia_controls": nil
  tag "check": "Verify that audit reduction capabilities are in place for the
Oracle audit data.  Since Oracle has no reduction capability per se, a
third-party tool or in-house-developed software must be in place to provide
this functionality.

If this capability has not been implemented, this is a finding."
  tag "fix": "Deploy software capable of performing audit data reduction."
end

