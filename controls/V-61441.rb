control 'V-61441' do
  title "The Oracle Listener must be configured to require administration
  authentication."
  desc "Oracle listener authentication helps prevent unauthorized
  administration of the Oracle listener. Unauthorized administration of the
  listener could lead to DoS exploits; loss of connection audit data,
  unauthorized reconfiguration or other unauthorized access. This is a Category I
  finding because privileged access to the listener is not restricted to
  authorized users. Unauthorized access can result in stopping of the listener
  (DoS) and overwriting of listener audit logs."
  impact 0.7
  tag "gtitle": 'SRG-APP-000516-DB-999900'
  tag "gid": 'V-61441'
  tag "rid": 'SV-75931r2_rule'
  tag "stig_id": 'O121-BP-022700'
  tag "fix_id": 'F-67357r1_fix'
  tag "cci": ['CCI-000366']
  tag "nist": ['CM-6 b', 'Rev_4']
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
  tag "check": "If a listener is not running on the local database host server,
  this check is not a finding.

  Note:  This check needs to be done only once per host system and once per
  listener. Multiple listeners may be defined on a single host system. They must
  all be reviewed, but only once per database home review.

  For subsequent database home reviews on the same host system, this check is not
  a finding.

  Determine all Listeners running on the host.

  For Windows hosts, view all Windows services with TNSListener embedded in the
  service name
    - The service name format is:
        Oracle[ORACLE_HOME_NAME]TNSListener

  For UNIX hosts, the Oracle Listener process will indicate the TNSLSNR
  executable.

  At a command prompt, issue the command:
    ps -ef | grep tnslsnr | grep -v grep

  The alias for the listener follows tnslsnr in the command output.

  Must be logged on the host system using the account that owns the tnslsnr
  executable (UNIX). If the account is denied local logon, have the system SA
  assist in this task by adding 'su' to the listener account from the root
  account. On Windows platforms, log on using an account with administrator
  privileges to complete the check.

  From a system command prompt, execute the listener control utility:

    lsnrctl status [LISTENER NAME]

  Review the results for the value of Security.

  If \"Security = OFF\" is displayed, this is a finding.

  If \"Security = ON: Local OS Authentication\" is displayed, this is not a
  finding.

  If \"Security = ON: Password or Local OS Authentication\", this is a finding
  (do not set a password on Oracle versions 10.1 and higher. Instead, use Local
  OS Authentication).

  Repeat the execution of the lsnrctl utility for all active listeners."
  tag "fix": "By default, Oracle Net Listener permits only local administration
  for security reasons. As a policy, the listener can be administered only by the
  user who started it. This is enforced through local operating system
  authentication. For example, if user1 starts the listener, then only user1 can
  administer it. Any other user trying to administer the listener gets an error.
  The super user is the only exception.

  Remote administration of the listener must not be permitted. If listener
  administration from a remote system is required, granting secure remote access
  to the Oracle DBMS server and performing local administration is preferred.
  Authorize and document this requirement in the System Security Plan.

  Note: In Oracle Database 12c Release 1 (12.1), the listener password feature is
  no longer supported. This does not cause a loss of security because
  authentication is enforced through local operating system authentication. Refer
  to Oracle Database Net Services Reference for additional information."

  listener_name = command("ps -ef | grep tnslsnr | grep -v grep|awk '{ print $9; }'").stdout.strip

  listener_status = command("lsnrctl status #{listener_name}").stdout.strip

  describe 'The Oracle Listener status' do
    subject { listener_status }
    it { should_not include 'Security                  OFF' }
    it { should_not include 'Security                  ON: Password or Local OS Authentication' }
  end
  describe listener_status do
    it { should_not be_empty }
  end
end
