require 'icalendar/tzinfo'

class Event
  def self.wedding(type=:attend_both)
    type = type.to_sym
    cal = Icalendar::Calendar.new

    tzid = "America/Los_Angeles"
    tz = TZInfo::Timezone.get tzid
    timezone = tz.ical_timezone Time.zone.local(2015, 6, 27, 12, 30)
    cal.add_timezone timezone

    cal.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new(Time.zone.local(2015, 6, 27, 12, 30), 'tzid' => tzid)
      e.dtend       = Icalendar::Values::DateTime.new(Time.zone.local(2015, 6, 27, 14, 30), 'tzid' => tzid)
      e.summary     = "Liza & Jerry Wedding Ceremony"
      e.description = "http://lizaandjerry.com"
      e.status      = "CONFIRMED"
      e.location    = "Menlo Park Presbyterian Church, 950 Santa Cruz Ave, Menlo Park, CA"
      # e.organizer   = "mailto:lizawlm@gmail.com"
      # e.organizer   = Icalendar::Values::CalAddress.new("mailto:lizawlm@gmail.com", cn: 'Liza & Jerry')
    end if type == :attend_both or type == :ceremony_only
    cal.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new(Time.zone.local(2015, 6, 27, 16, 30), 'tzid' => tzid)
      e.dtend       = Icalendar::Values::DateTime.new(Time.zone.local(2015, 6, 27, 22, 00), 'tzid' => tzid)
      e.summary     = "Liza & Jerry Wedding Reception"
      e.description = "http://lizaandjerry.com"
      e.status      = "CONFIRMED"
      e.location    = "Byington Winery & Vineyard, 21850 Bear Creek Rd, Los Gatos, CA"
      # e.organizer   = "mailto:lizawlm@gmail.com"
      # e.organizer   = Icalendar::Values::CalAddress.new("mailto:lizawlm@gmail.com", cn: 'Liza & Jerry')
    end if type == :attend_both
    cal
  end
end
