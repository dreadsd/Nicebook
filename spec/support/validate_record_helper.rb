module RecordValidations
  def check_validation_of(record, method)
    expect(record.send(method)).to be true
    if method == :invalid?
      expect { record.save! }.to raise_error(ActiveRecord::RecordInvalid)
    else
      expect { record.save! }.not_to raise_error
    end
  end
end
