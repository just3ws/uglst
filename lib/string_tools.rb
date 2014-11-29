module StringTools
  def self.parse_csv_string_to_array(csv)
    if csv.present?
      csv.to_s.split(',').map(&:downcase).map(&:strip).compact.sort.reject(&:blank?).uniq
    else
      csv
    end
  end
end
